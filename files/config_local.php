<?php
    if (!isset($config))
        $config = array();

    /*
     * The directory containing calibre's metadata.db file, with sub-directories
     * containing all the formats.
     * BEWARE : it has to end with a /
     */
    $config['calibre_directory'] = '/books/';

    /*
     * Catalog's title
     */
    $cops_title = getenv('COPS_TITLE');
    $cops_title = $cops_title ? $cops_title : 'COPS';
    $config['cops_title_default'] = $cops_title;

    /*
     * use URL rewriting for downloading of ebook in HTML catalog
     * See README for more information
     *  1 : enable
     *  0 : disable
     */
    $config['cops_use_url_rewriting'] = "0";
