# Generate Types

```shell
# Generate JavaScript Bundle
$ npx pbjs -o prototypes/index.js -t static-module ../protobufs/core.proto
# Generate .d.ts file
$ npx pbts -o ./prototypes/index.d.ts ./prototypes/index.js
```