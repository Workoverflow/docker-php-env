# Docker environment for PHP projects

Docker container with NGINX + PHP 8.1-FPM
Ready for Symfony 6 and Laravel 9

**How to use?**

1. Clone this repository

    ```bash
    git clone https://github.com/Workoverflow/docker-php-env.git
    ```
   
2. Edit *docker/config/env/dev.env* before build and run 
    
3. Use docker-compose or Make

    ```bash
    docker-compose --env-file ./docker/config/env/dev.env build
    docker-compose --env-file ./docker/config/env/dev.env up -d
    ```

    ```bash
    make build.dev run.dev
    ```

4. Check php info in your browser. Visit http://localhost/ 

5. Attach to container

    ```bash
    docker compose exec php sh
    ```

    OR 

    ```bash
    doocker exec -it php_app /bin/sh
    ```

6. Remove default *app* folder
    
    ```bash 
    cd .. && rm -rf app
    ```

7. Create new Symfony 6 project or use other framework

    ```bash
    composer create-project symfony/website-skeleton app
    ```

8. Refresh http://localhost/

9. Use http://localhost:8080/ to manage database