import type { MarkdownInstance } from "astro";
export interface ITreeNode {
  value: MarkdownInstance<Record<string, any>>;
  children?: ITreeNode[];
}

export function parseToc(
  instances: MarkdownInstance<Record<string, any>>[]
): ITreeNode[] {
  function insertNode(list: ITreeNode[], item: ITreeNode) {
    const index = list.findIndex(
      (v) => v.value.frontmatter["index"] > item.value.frontmatter["index"]
    );
    if (index === -1) {
      list.push(item);
    } else {
      list.splice(index, 0, item);
    }
  }

  const markdownMap = new Map<number, ITreeNode>();
  const nodes: ITreeNode[] = [];
  for (const post of instances) {
    const node: ITreeNode = {
      value: post,
    };
    const index = post.frontmatter["index"];
    markdownMap.set(index, node);
  }
  for (const post of instances) {
    const node = markdownMap.get(post.frontmatter["index"]);
    const parent = markdownMap.get(post.frontmatter["parent_index"]);
    if (parent) {
      if (!parent.children) {
        parent.children = [];
      }
      insertNode(parent.children, node!);
    } else {
      insertNode(nodes, node!);
    }
  }

  return nodes;
}
