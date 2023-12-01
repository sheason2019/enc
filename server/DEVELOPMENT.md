# Generate Types

```shell
# Generate JavaScript Bundle
$ npx pbjs -o src/prototypes/index.js -t static-module ../protobufs/core.proto
# Generate .d.ts file
$ npx pbts -o ./src/prototypes/index.d.ts ./src/prototypes/index.js
```