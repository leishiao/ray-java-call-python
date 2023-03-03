# Ray Java Call Python Example

示例代码来自Ray文档：https://docs.ray.io/en/latest/ray-core/cross-language.html?highlight=cross

## 问题：

​	使用Java代码通过Ray调用python代码，按照Ray文档`https://docs.ray.io/en/latest/ray-core/cross-language.html?highlight=cross` 中关于java调用python的步骤执行成功。

​	文档中的Ray实例是在执行`Ray.init();`时启动的，但这里想用一个已经存在的Ray实例，因此构建如下测试环境：

​	宿主机IP：`192.168.0.119`

​	Ray实例运行在本地容器A中，容器内分配IP1：`192.168.66.2`，映射多个Ray使用的端口。

​	Java代码运行在本地容器B中，容器内分配IP2：`192.168.67.2`，未映射端口。IP1和IP2不在同一个网段。
在
​	在容器B中执行Java程序时通过`-Dray.address`参数指定Ray实例容器所在宿主机IP地址,即：`-Dray.address=192.168.0.119:6379`

​	Java程序报错，日志如下：

```shell
JavaCallPython!
WARNING: sun.reflect.Reflection.getCallerClass is not supported. This will impact performance.
07:49:06.765 [main] DEBUG io.ray.runtime.DefaultRayRuntimeFactory - Initializing runtime with config: {"ray":{"address":"192.168.0.119:6379","head-args":[],"job":{"code-search-path":"/root/code/python","default-actor-lifetime":"NON_DETACHED","id":"","jvm-options":[],"namespace":"","runtime-env":{"config":{},"env-vars":{},"jars":[]}},"logging":{"dir":"","level":"INFO","loggers":[],"max-backup-files":10,"max-file-size":"500MB","pattern":"%d{yyyy-MM-dd HH:mm:ss,SSS} %p %c{1} [%t]: %m%n"},"object-store":{"socket-name":null},"raylet":{"node-manager-port":0,"socket-name":null,"startup-token":0},"redis":{"password":"5241590000000000"},"run-mode":"CLUSTER","session-dir":null,"worker":{"mode":"DRIVER"}}}
07:49:06.773 [main] DEBUG io.ray.runtime.util.JniUtils - Loading native library core_worker_library_java in /tmp/ray/1677829746771.
07:49:06.908 [main] DEBUG io.ray.runtime.util.JniUtils - Native library loaded.
[2023-03-03 07:49:06,910 W 1731 1732] global_state_accessor.cc:390: Some processes that the driver needs to connect to have not registered with GCS, so retrying. Have you run 'ray start' on this node?
[2023-03-03 07:49:07,912 W 1731 1732] global_state_accessor.cc:390: Some processes that the driver needs to connect to have not registered with GCS, so retrying. Have you run 'ray start' on this node?
[2023-03-03 07:49:08,914 W 1731 1732] global_state_accessor.cc:390: Some processes that the driver needs to connect to have not registered with GCS, so retrying. Have you run 'ray start' on this node?
[2023-03-03 07:49:09,914 W 1731 1732] global_state_accessor.cc:390: Some processes that the driver needs to connect to have not registered with GCS, so retrying. Have you run 'ray start' on this node?
[2023-03-03 07:49:10,915 W 1731 1732] global_state_accessor.cc:390: Some processes that the driver needs to connect to have not registered with GCS, so retrying. Have you run 'ray start' on this node?
[2023-03-03 07:49:11,917 W 1731 1732] global_state_accessor.cc:390: Some processes that the driver needs to connect to have not registered with GCS, so retrying. Have you run 'ray start' on this node?
[2023-03-03 07:49:12,919 W 1731 1732] global_state_accessor.cc:390: Some processes that the driver needs to connect to have not registered with GCS, so retrying. Have you run 'ray start' on this node?
[2023-03-03 07:49:13,921 W 1731 1732] global_state_accessor.cc:390: Some processes that the driver needs to connect to have not registered with GCS, so retrying. Have you run 'ray start' on this node?
[2023-03-03 07:49:14,923 W 1731 1732] global_state_accessor.cc:390: Some processes that the driver needs to connect to have not registered with GCS, so retrying. Have you run 'ray start' on this node?
[2023-03-03 07:49:15,925 W 1731 1732] global_state_accessor.cc:390: Some processes that the driver needs to connect to have not registered with GCS, so retrying. Have you run 'ray start' on this node?
07:49:16.928 [main] ERROR io.ray.runtime.DefaultRayRuntimeFactory - Failed to initialize ray runtime, with config {"ray":{"address":"192.168.0.119:6379","head-args":[],"job":{"code-search-path":"/root/code/python","default-actor-lifetime":"NON_DETACHED","id":"","jvm-options":[],"namespace":"","runtime-env":{"config":{},"env-vars":{},"jars":[]}},"logging":{"dir":"","level":"INFO","loggers":[],"max-backup-files":10,"max-file-size":"500MB","pattern":"%d{yyyy-MM-dd HH:mm:ss,SSS} %p %c{1} [%t]: %m%n"},"object-store":{"socket-name":null},"raylet":{"node-manager-port":0,"socket-name":null,"startup-token":0},"redis":{"password":"5241590000000000"},"run-mode":"CLUSTER","session-dir":"/tmp/ray/session_2023-03-03_07-32-28_747703_1","worker":{"mode":"DRIVER"}}}
io.ray.api.exception.RayException: This node has an IP address of 192.168.67.2, and Ray expects this IP address to be either the GCS address or one of the Raylet addresses. Connected to GCS at 192.168.0.119 and found raylets at 192.168.66.2 but none of these match this node's IP 192.168.67.2. Are any of these actually a different IP address for the same node?You might need to provide --node-ip-address to specify the IP address that the head should use when sending to this node.
	at io.ray.runtime.gcs.GlobalStateAccessor.nativeGetNodeToConnectForDriver(Native Method)
	at io.ray.runtime.gcs.GlobalStateAccessor.getNodeToConnectForDriver(GlobalStateAccessor.java:126)
	at io.ray.runtime.gcs.GcsClient.getNodeToConnectForDriver(GcsClient.java:136)
	at io.ray.runtime.RayNativeRuntime.start(RayNativeRuntime.java:92)
	at io.ray.runtime.DefaultRayRuntimeFactory.createRayRuntime(DefaultRayRuntimeFactory.java:35)
	at io.ray.api.Ray.init(Ray.java:32)
	at io.ray.api.Ray.init(Ray.java:19)
	at demo.JavaCallPython.main(JavaCallPython.java:17)
Exception in thread "main" java.lang.RuntimeException: Failed to initialize Ray runtime.
	at io.ray.api.Ray.init(Ray.java:21)
	at demo.JavaCallPython.main(JavaCallPython.java:17)
Caused by: java.lang.RuntimeException: Failed to initialize ray runtime
	at io.ray.runtime.DefaultRayRuntimeFactory.createRayRuntime(DefaultRayRuntimeFactory.java:39)
	at io.ray.api.Ray.init(Ray.java:32)
	at io.ray.api.Ray.init(Ray.java:19)
	... 1 more
Caused by: io.ray.api.exception.RayException: This node has an IP address of 192.168.67.2, and Ray expects this IP address to be either the GCS address or one of the Raylet addresses. Connected to GCS at 192.168.0.119 and found raylets at 192.168.66.2 but none of these match this node's IP 192.168.67.2. Are any of these actually a different IP address for the same node?You might need to provide --node-ip-address to specify the IP address that the head should use when sending to this node.
	at io.ray.runtime.gcs.GlobalStateAccessor.nativeGetNodeToConnectForDriver(Native Method)
	at io.ray.runtime.gcs.GlobalStateAccessor.getNodeToConnectForDriver(GlobalStateAccessor.java:126)
	at io.ray.runtime.gcs.GcsClient.getNodeToConnectForDriver(GcsClient.java:136)
	at io.ray.runtime.RayNativeRuntime.start(RayNativeRuntime.java:92)
	at io.ray.runtime.DefaultRayRuntimeFactory.createRayRuntime(DefaultRayRuntimeFactory.java:35)
	... 3 more

```



## 复现步骤：

1. 进入docker目录，执行`build_ray_image.sh`脚本构建ray镜像`demo-ray:latest`，执行`build_dev_image.sh`脚本构建Java环境镜像`demo-dev:latest`
2. 执行`docker-compose up -d` 启动Ray实例和Java开发环境
3. 执行`docker exec -it demo_dev bash`进入Java环境容器`demo-dev`
4. 在Java环境容器，执行`cd /root/code`进入代码目录
5. 在Java环境容器，执行`build.sh`脚本编译打包Java代码
6. 在Java环境容器，执行`run_local.sh`脚本运行Java程序，`run_local.sh`脚本没有指定`-Dray.address`参数，能运行成功
7. 在Java环境容器，修改`run_cluster.sh`脚本中`HOST_IP_ADDRESS`为宿主机IP地址并执行，出现上述异常，`run_cluster.sh`脚本指定了`-Dray.address`参数


运行`test_ray.py`能连接并使用Ray实例