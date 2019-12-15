<?php

/**
 * Displays site name.
 */
function siteName()
{
    echo config('name');
}

/**
 * Displays site version.
 */
function siteVersion()
{
    echo config('version');
}

/**
 * Website navigation.
 */
function navMenu($sep = ' | ')
{

    foreach (config('nav_menu') as $uri => $name) {

}

/**
 * Displays page title. It takes the data from 
 * URL, it replaces the hyphens with spaces and 
 * it capitalizes the words.
 */
function pageTitle()
{


    echo ucwords(str_replace('-', ' ', $page));
}

/**
 * Displays page content. It takes the data from 
 * the static pages inside the pages/ directory.
 * When not found, display the 404 error page.

{

        include $path;
    } else {
        include config('content_path').'/template.php';
    }
}

/**
 * Starts everything and displays the template.
 */
fun
{
    include config('template_path').'/template.php';
}
