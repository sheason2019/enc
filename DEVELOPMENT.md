# Protobuf

更新 Protobuf。

```sh
protoc --proto_path=".\protos" --dart_out=".\lib\prototypes" ".\protos\core.proto"
```

# Windows 打包步骤

构建应用：

https://flutter.cn/docs/platform-integration/windows/building#msix-packaging

安装应用：

https://blog.51cto.com/ducafecat/5005254

# Android 打包步骤

```sh
$ flutter build apk --split-per-abi
```
