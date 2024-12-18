<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInit73088c10918bc2368a319ffe1baf81ff
{
    public static $prefixLengthsPsr4 = array (
        'P' => 
        array (
            'ProjetMVC\\' => 10,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'ProjetMVC\\' => 
        array (
            0 => __DIR__ . '/../..' . '/src',
        ),
    );

    public static $classMap = array (
        'Composer\\InstalledVersions' => __DIR__ . '/..' . '/composer/InstalledVersions.php',
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInit73088c10918bc2368a319ffe1baf81ff::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInit73088c10918bc2368a319ffe1baf81ff::$prefixDirsPsr4;
            $loader->classMap = ComposerStaticInit73088c10918bc2368a319ffe1baf81ff::$classMap;

        }, null, ClassLoader::class);
    }
}
