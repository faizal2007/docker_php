<?php
/**
 * phpMyAdmin sample configuration, you can use it as base for
 * manual configuration. For easier setup you can use setup/
 *
 * All directives are explained in documentation in the doc/ folder
 * or at <https://docs.phpmyadmin.net/>.
 */

declare(strict_types=1);

/**
 * This is needed for cookie based authentication to encrypt password in
 * cookie. Needs to be 32 chars long.
 */
$cfg['blowfish_secret'] = 'b7a84a9c8f00e604e80b54dc5426c1db'; /* YOU MUST FILL IN THIS FOR COOKIE AUTH! */

/**
 * Servers configuration
 */

/**
 * First server
 */
/* Authentication type */
$cfg['Servers'][1]['auth_type'] = 'cookie';
/* Server parameters */
$cfg['Servers'][1]['host'] = '192.168.1.112';
$cfg['Servers'][1]['compress'] = false;
$cfg['Servers'][1]['AllowNoPassword'] = false;
/**
 * phpMyAdmin configuration storage settings.
 */

/* User used to manipulate with storage */
// $cfg['Servers'][1]['controlhost'] = '';
// $cfg['Servers'][1]['controlport'] = '';
// $cfg['Servers'][1]['controluser'] = 'pma';
// $cfg['Servers'][1]['controlpass'] = 'pmapass';

/* Storage database and tables */
 $cfg['Servers'][1]['pmadb'] = 'phpmyadmin';
 $cfg['Servers'][1]['bookmarktable'] = 'pma__bookmark';
 $cfg['Servers'][1]['relation'] = 'pma__relation';
 $cfg['Servers'][1]['table_info'] = 'pma__table_info';
 $cfg['Servers'][1]['table_coords'] = 'pma__table_coords';
 $cfg['Servers'][1]['pdf_pages'] = 'pma__pdf_pages';
 $cfg['Servers'][1]['column_info'] = 'pma__column_info';
 $cfg['Servers'][1]['history'] = 'pma__history';
 $cfg['Servers'][1]['table_uiprefs'] = 'pma__table_uiprefs';
 $cfg['Servers'][1]['tracking'] = 'pma__tracking';
 $cfg['Servers'][1]['userconfig'] = 'pma__userconfig';
 $cfg['Servers'][1]['recent'] = 'pma__recent';
 $cfg['Servers'][1]['favorite'] = 'pma__favorite';
 $cfg['Servers'][1]['users'] = 'pma__users';
 $cfg['Servers'][1]['usergroups'] = 'pma__usergroups';
 $cfg['Servers'][1]['navigationhiding'] = 'pma__navigationhiding';
 $cfg['Servers'][1]['savedsearches'] = 'pma__savedsearches';
 $cfg['Servers'][1]['central_columns'] = 'pma__central_columns';
 $cfg['Servers'][1]['designer_settings'] = 'pma__designer_settings';
 $cfg['Servers'][1]['export_templates'] = 'pma__export_templates';

/**
 * End of servers configuration
 */

/**
 * Directories for saving/loading files from server
 */
$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';

/**
 * Whether to display icons or text or both icons and text in table row
 * action segment. Value can be either of 'icons', 'text' or 'both'.
 * default = 'both'
 */
//$cfg['RowActionType'] = 'icons';

/**
 * Defines whether a user should be displayed a "show all (records)"
 * button in browse mode or not.
 * default = false
 */
$cfg['ShowAll'] = true;
?>
