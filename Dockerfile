FROM ubuntu:18.04

RUN apt-get update && apt-get -y install apache2
RUN echo 'Docker Container Application.' > /var/www/html/index.html

# 필요한 작업 경로를 생성. (WORKDIR 로 지정해도 됨)
RUN mkdir /webapp

# 아파치2에 필요한 환경변수, 디렉터리, 서비스 실행 등의 정보를 셀 스크립트에 작성하고 실행 권한을 부여한다.
RUN echo '. /etc/apache2/envvars' > /webapp/run_http.sh && \
    echo 'mkdir -p /var/run/apache2' >> /webapp/run_http.sh && \
    echo 'mkdir -p /var/lock/apache2' >> /webapp/run_http.sh && \
    echo '/usr/sbin/apache2 -D FOREGROUND' >> /webapp/run_http.sh && \
    chmod 744 /webapp/run_http.sh
    
EXPOSE 80

# RUN 명령어로 작성된 셀 스크립트를 컨테이너가 동작할 때 실행한다. 
CMD /webapp/run_http.sh
