cifaz.ansible-ops-env
========================

通用的内部测试环境建立工具  
本工具的目的是使用ansible尽可能快的时间建立一套测试环境环境  
因此本工具是一套集成工具, 可以使用一些约定方法,   
快速建立起自己的一套基本的自动化环境  

基本安装命令, 建议使用下面的初始化
```
ansible-galaxy install cifaz.ops-env
```

### 你在使用本工具前可以先使用如下工具初始化你的基本环境
 - [阿里云YUM安装脚本](yumforali.sh) 可以快速将你的服务器切换为阿里云YUM
 - [环境初始化EPEL](centos-env-init.sh)   
    1.可以初始化基本目录,   
    2.初始化常用依赖组件/工具(如ansible/jumpserver的依赖)   
    3.更换时区和设置中国时间, 更新yum缓存  
    4.**其它自己按需设定**
    
### 安装ansible环境 - 目前仅限于centos7
````
以上常用依赖(环境初始化EPEL)已经初始化过EPEL了, 如果没有使用以上脚本请自行初始化环境
yum install -y ansible
  
安装完毕检查
ansible --version
  
ansible配置
mkdir -p /app/data/ansible/hosts/ && mkdir -p /app/data/ansible/playbooks/
  
vi /etc/ansible/ansible.cfg
加下如下配置 [defaults]节点下
inventory=/app/data/ansible/hosts/
roles_path=/app/data/ansible/playbooks/roles:/etc/ansible/roles:/usr/share/ansible/roles
host_key_checking = False
callback_whitelist = profile_tasks

初始化完毕, cifaz库, 安装时会把常用库都安装进来
ansible-galaxy install cifaz.ops-env
  
开始准备自动部署吧
````

### 测试环境安装部署
```
- 建立机器配置
  建议同类机器建立, 如
  web: web机器
  db: 数据库, 主数据库
  db2: 从数据库, 备份数据
  ops: 运维机器, 一般指本机, 也可以用local
  public: 公共组件机器
  各种机器类型又可以再进行细分
   
  touch /app/data/ansible/hosts/web
  touch /app/data/ansible/hosts/db
  touch /app/data/ansible/hosts/local
  touch /app/data/ansible/hosts/public
  
- 下载任务编排
  暂时没办法使用roles, 直接使用playbook进行任务编排
  cd /app/data/ansible/playbooks/ && git clone https://github.com/cifaz/ansiblerepo.git
  
- 初始化分发ssh-key
  ansible-playbook generate-ssh-key.yml
  ansible-playbook push-ssh-key.yml
  
- 分环境(请自行划分)
  运维机一台, jdk, jumpserver, dnsmasq, openvpn, jenkins, nginx, zentao, xwiki
  仓库服务, gitlab, nexus
  WEB服务二台, nodejs, jdk, tomcat, zookeeper
  数据库一台, kafka, redis, mysql, mongodb
  基础服务, 业务服务, 暂无, 和WEB服务有点像, 如CAS, dubbo监控, 部署服务等
  
- 运维机
  常规安装, 
  如下配置需要自己处理
  nginx, /etc/nginx/nginx.conf 及 /etc/nginx/conf.d/下的文件需要建立, 模板
  dnsmasq, /etc/dnsmasq.d/下建立自己的域名拦截解析, 模板
```


### 注意
- 遇到[ERROR]: failed to download the file时, 请重新下载
- 下载时提示已下载
```
[WARNING]: - cifaz.ops-env (master) is already installed - use --force to change version to unspecified
加 -f 参数重新强制下载
ansible-galaxy install cifaz.ops-env -f
```

License
-------

MIT

Author Information
------------------

ccz <hanlin2531@163.com>

