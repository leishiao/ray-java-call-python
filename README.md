# Ray Java Call Python Example

示例代码来自Ray文档：https://docs.ray.io/en/latest/ray-core/cross-language.html?highlight=cross

## 说明：

​	使用Java代码通过Ray调用python代码，按照Ray文档`https://docs.ray.io/en/latest/ray-core/cross-language.html?highlight=cross` 中关于java调用python的步骤执行成功。

​	文档中的Ray实例是在执行`Ray.init();`时启动的，但这里想用一个已经存在的Ray实例，因此构建如下测试环境：

​	宿主机IP1：`192.168.66.1`

​	宿主机IP2：`192.168.67.1`

​	Ray实例运行在宿主机的容器A内，映射多个Ray使用的端口。

​	Java代码运行在在宿主机的容器B内，映射多个Ray使用的端口。

​	容器B内也需要启动Ray实例，参考docker-compose.yml

​	在容器B中执行Java程序时指定参数，`-Dray.address=192.168.66.1:6379 -Dray.node-ip=192.168.67.1`，参考run_cluster.sh


## 步骤：

1. 进入docker目录，执行`build_ray_image.sh`脚本构建ray镜像`demo-ray:latest`，执行`build_dev_image.sh`脚本构建Java环境镜像`demo-dev:latest`
2. 执行`docker-compose up -d` 启动Ray实例和Java开发环境
3. 执行`docker exec -it demo_dev bash`进入Java环境容器`demo-dev`
4. 在Java环境容器，执行`cd /root/code`进入代码目录，运行`test_ray.py`测试能否连接并使用Ray实例
5. 在Java环境容器，执行`build.sh`脚本编译打包Java代码
6. 在Java环境容器，执行`run_local.sh`脚本运行Java程序，`run_local.sh`脚本没有指定`-Dray.address`参数
7. 在Java环境容器，修改`run_cluster.sh`脚本中`HOST_IP_ADDRESS`为宿主机IP地址，并执行

