#!/bin/bash
ip_address=$(ip -o route get to 8.8.8.8 | sed -n 's/.*src \([0-9.]\+\).*/\1/p')

# Generate a 32-byte Blowfish secret using /dev/urandom
blowfish_secret=$(od -An -vtx1 -N16 /dev/urandom | tr -d ' \n')
i=1
[ ! -d "./conf" ] && mkdir -p "./conf"

cat <<EOF> ./conf/config.inc.php
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
\$cfg['blowfish_secret'] = '$blowfish_secret'; /* YOU MUST FILL IN THIS FOR COOKIE AUTH! */

/**
 * Servers configuration
 */

/**
 * First server
 */
/* Authentication type */
\$cfg['Servers'][$i]['auth_type'] = 'cookie';
/* Server parameters */
\$cfg['Servers'][$i]['host'] = '$ip_address';
\$cfg['Servers'][$i]['compress'] = false;
\$cfg['Servers'][$i]['AllowNoPassword'] = false;
/**
 * phpMyAdmin configuration storage settings.
 */

/* User used to manipulate with storage */
// \$cfg['Servers'][$i]['controlhost'] = '';
// \$cfg['Servers'][$i]['controlport'] = '';
// \$cfg['Servers'][$i]['controluser'] = 'pma';
// \$cfg['Servers'][$i]['controlpass'] = 'pmapass';

/* Storage database and tables */
 \$cfg['Servers'][$i]['pmadb'] = 'phpmyadmin';
 \$cfg['Servers'][$i]['bookmarktable'] = 'pma__bookmark';
 \$cfg['Servers'][$i]['relation'] = 'pma__relation';
 \$cfg['Servers'][$i]['table_info'] = 'pma__table_info';
 \$cfg['Servers'][$i]['table_coords'] = 'pma__table_coords';
 \$cfg['Servers'][$i]['pdf_pages'] = 'pma__pdf_pages';
 \$cfg['Servers'][$i]['column_info'] = 'pma__column_info';
 \$cfg['Servers'][$i]['history'] = 'pma__history';
 \$cfg['Servers'][$i]['table_uiprefs'] = 'pma__table_uiprefs';
 \$cfg['Servers'][$i]['tracking'] = 'pma__tracking';
 \$cfg['Servers'][$i]['userconfig'] = 'pma__userconfig';
 \$cfg['Servers'][$i]['recent'] = 'pma__recent';
 \$cfg['Servers'][$i]['favorite'] = 'pma__favorite';
 \$cfg['Servers'][$i]['users'] = 'pma__users';
 \$cfg['Servers'][$i]['usergroups'] = 'pma__usergroups';
 \$cfg['Servers'][$i]['navigationhiding'] = 'pma__navigationhiding';
 \$cfg['Servers'][$i]['savedsearches'] = 'pma__savedsearches';
 \$cfg['Servers'][$i]['central_columns'] = 'pma__central_columns';
 \$cfg['Servers'][$i]['designer_settings'] = 'pma__designer_settings';
 \$cfg['Servers'][$i]['export_templates'] = 'pma__export_templates';

/**
 * End of servers configuration
 */

/**
 * Directories for saving/loading files from server
 */
\$cfg['UploadDir'] = '';
\$cfg['SaveDir'] = '';

/**
 * Whether to display icons or text or both icons and text in table row
 * action segment. Value can be either of 'icons', 'text' or 'both'.
 * default = 'both'
 */
//\$cfg['RowActionType'] = 'icons';

/**
 * Defines whether a user should be displayed a "show all (records)"
 * button in browse mode or not.
 * default = false
 */
\$cfg['ShowAll'] = true;
?>
EOF

