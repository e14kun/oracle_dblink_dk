git clone 할때는
id_rsa 를 반드시 권한 400 으로 해야함

$ cat ~/.ssh/config
Host github_e14
    HostName github.com
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/.e14_rsa.pub

$ cat ~/.ssh/.e14_rsa.pub
~~ public key 내용 ~~

$ ssh-add ~/.ssh/.e14_rsa
$ ssh-add -l

$ cat ~/.ssh/.e14_rsa
~~ private key 내용 ~~


cf) https://github.com/wnameless/docker-oracle-xe-11g

참조해서 2개 만들었고
# ora (local 에서 시행)
podman network inspect jy_network
podman run -dt -p49161:1521 -p7091:8080 --network jy_network --ip 10.89.0.11 -e ORACLE_ENABLE_XDB=true -e ORACLE_ALLOW_REMOTE=true -e ORACLE_DISABLE_ASYNCH_IO=true --name oracle-xe-11g oracle-xe-11g
podman run -dt -p49162:1521 -p7092:8080 --network jy_network --ip 10.89.0.12 -e ORACLE_ENABLE_XDB=true -e ORACLE_ALLOW_REMOTE=true -e ORACLE_DISABLE_ASYNCH_IO=true --name oracle-xe-11g-v oracle-xe-11g-v2

두개 만들었음


git clone https://github.com/wnameless/docker-oracle-xe-11g.git
cd docker-oracle-xe-11g
docker build -t wnameless/oracle-xe-11g .

# 활용된 커멘드들

$ ncat -l -p12345
$ nc -l -p12345
$ echo "this is 11 container!" | nc -l -p12345
$ apt install iputils-ping
$ echo this is 11 | nc -l -p11111
$ echo this is 11 | nc -l -p80
$ cd /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora
$ tnsping JY_SERV1
$ cat tnsnames.ora
$ tnsping JY_SERV_1
$ lsnrctl status
$ lsnrctl start
$ cd /u01/app/oracle/product/11.2.0/xe/network/admin/
$ ls -alhc /u01/app/oracle/product/11.2.0/xe/log/diag/tnslsnr/d7d2fc8576dc/listener/alert/log.xml
$ vim listener.ora
$ vim tnsnames.ora
$ sqlplus sys as sysdba <- password is oracle
