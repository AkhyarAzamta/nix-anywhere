{ pkgs, username, ... }:
let
  php = pkgs.php83.buildEnv {
    extensions =
      { enabled, all }:
      enabled
      ++ (with all; [
        bcmath
        calendar
        ctype
        curl
        dom
        exif
        fileinfo
        filter
        gd
        iconv
        intl
        mbstring
        mysqli
        mysqlnd
        opcache
        openssl
        pdo
        pdo_mysql
        pdo_pgsql
        pgsql
        posix
        readline
        redis
        session
        simplexml
        sockets
        sodium
        tokenizer
        xml
        xmlreader
        xmlwriter
        zip
        zlib
      ]);
    extraConfig = ''
      memory_limit = 512M
      upload_max_filesize = 100M
      post_max_size = 100M
      max_execution_time = 300
    '';
  };
in
{
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      php
      php.packages.composer
      mariadb.client
      postgresql
      redis
    ];

    programs.zsh.shellAliases = {
      pa = "php artisan";
      pas = "php artisan serve";
      pam = "php artisan migrate";
      pamf = "php artisan migrate:fresh";
      pamfs = "php artisan migrate:fresh --seed";
      par = "php artisan route:list";
      pac = "php artisan cache:clear";
      paoc = "php artisan optimize:clear";
      ci = "composer install";
      cu = "composer update";
      cr = "composer require";
      crd = "composer require --dev";
      cda = "composer dump-autoload";
    };
  };
}
