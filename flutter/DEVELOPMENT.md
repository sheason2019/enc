# Protobuf

更新 Protobuf。

```sh
protoc --proto_path="..\protobufs" --dart_out=".\lib\prototypes" "..\protobufs\core.proto"
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

# Drift

创建 Schema

```sh
$ dart run drift_dev schema dump lib/schema/database.dart lib/schema/schemas
```

生成 StepByStep 迁移

```sh
$ dart run drift_dev schema steps lib/schema/schemas lib/schema/schema_versions.dart
```