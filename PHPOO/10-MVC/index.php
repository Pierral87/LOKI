<?php

use ProjetMVC\Controller\UserController;

require("vendor/autoload.php");
require("inc/config.php");

// require("template.php");

$controller = new UserController;

$controller->handleRequest();