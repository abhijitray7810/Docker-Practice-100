version: '3'

services:
    web:
        build: ./app
        container_name: python
        ports:
            - "5000:5000"
        volumes:
            - ./app:/code
        depends_on:
            - redis
    redis:
        image: redis:alpine
        container_name: redis
