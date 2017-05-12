# docker-lnmp

## 简介
+ 一个容器仅运行一种服务，而不是将所有的服务都放在一个容器中，增强了可扩展性；
+ 将`PHP`项目所需的`Nginx`、`PHP`、`MySQL`组件，分别运行在各自镜像所创建出的独立容器中，降低它们之间的耦合度；
+ Blog: [详解](https://www.xiaocoder.com/2017/05/12/docker-8)；

## 拉取资源

```bash
git clone https://github.com/YuXiaoCoder/docker-lnmp.git
```

## 构建镜像

```bash
cd docker-lnmp/scripts/
./build_images.sh
```

## 启动容器

```bash
cd docker-lnmp/scripts/
./run_containers.sh
```

## 测试服务

+ 在网页根目录中，默认为`/data/www`；

+ 编写`index.html`文件

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Hello</title>
</head>
<body>
    <h1>Hello，World！</h1>
</body>
</html>
```

+ 编写`info.php`文件

```text
<?php                                                                                                                                                           

// date
echo date("Y-m-d H:i:s")."<br />\n";

// mysql
try {
    $conn = new PDO('mysql:host=mysql;port=3306;dbname=mysql;charset=utf8', 'root', '0901');
    echo 'Connection succeed.';
} catch (PDOException $e) {
    echo 'Connection failed: ' . $e->getMessage();
}

// phpinfo
phpinfo();
?>
```

+ 使用浏览器访问，`http://<IP地址>/index.html`与`http://<IP地址>/info.php`
