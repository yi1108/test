# 使用官方 Maven 镜像作为构建阶段
FROM maven:3.9.4-eclipse-temurin-17 AS build

# 设置工作目录
WORKDIR /app

# 将 Maven 的配置文件复制到镜像中（如有必要）
# COPY settings.xml /root/.m2/settings.xml

# 复制项目的 pom.xml 文件和依赖相关信息
COPY pom.xml .

# 下载依赖，利用 Docker 缓存优化构建
RUN mvn dependency:go-offline

# 复制项目源码到镜像
COPY src ./src

# 使用 Maven 打包项目
RUN mvn clean package -DskipTests

# 使用轻量级 JRE 镜像作为运行阶段
FROM eclipse-temurin:17-jre

# 设置工作目录
WORKDIR /app

# 从构建阶段复制生成的 Jar 包到运行镜像
COPY --from=build /app/target/*.jar app.jar

# 暴露服务运行的端口
EXPOSE 8080

# 设置容器启动命令
ENTRYPOINT ["java", "-jar", "app.jar"]
