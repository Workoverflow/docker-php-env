# Docker environment for PHP projects

Docker container with NGINX + PHP 8.1-FPM
Ready for Symfony 6 and Laravel 9

**How to use?**

1. Clone this repository

    ```bash
    git clone https://github.com/Workoverflow/docker-php-env.git
    ```
    
2. Use docker-compose or docker run


    ```bash
    docker compose build
    docker compose up -d
    ```

    OR

    ```bash
    docker build -t php-app:latest .
    docker run -d -p 80:80 --name=php_app php-app:latest
    ```

3. Check php info in your browser. Visit http://localhost/
    

4. Attach to container

    ```bash
    docker compose exec php sh
    ```

    OR 

    ```bash
    doocker exec -it php_app /bin/sh
    ```

5. Remove default *app* folder
    
    ```bash 
    cd .. && rm -rf app
    ```

6. Create new Symfony 6 project or use other framework

    ```bash
    composer create-project symfony/website-skeleton app
    ```

7. Refresh http://localhost/