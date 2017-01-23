<?php
$CONF['database_type'] = 'mysqli';
$CONF['database_user'] = 'postfix';
$CONF['database_password'] = '{{SQL_USR_PW}}';
$CONF['database_name'] = 'vmail';
$CONF['database_host'] = '{{MYSQL_HOST}}';

$CONF['admin_email'] = '{{ADMIN_MAIL}}';
$CONF['encrypt'] = 'dovecot:SSHA512';
$CONF['dovecotpw'] = "/usr/bin/doveadm pw";
$CONF['configured'] = true;

$CONF['default_aliases'] = array (
    'abuse' => 'abuse@{{DOMAIN}}',
    'hostmaster' => 'hostmaster@{{DOMAIN}}',
    'postmaster' => 'postmaster@{{DOMAIN}}',
    'webmaster' => 'webmaster@{{DOMAIN}}'
);

$CONF['vacation_domain'] = 'autoreply.{{DOMAIN}}';
$CONF['footer_text'] = 'Return to {{DOMAIN}}';
$CONF['footer_link'] = 'http://{{DOMAIN}}';

$CONF['smtp_server'] = '{{SMTP_SERVER}}';
$CONF['smtp_port'] = '25';

$CONF['smtp_client'] = '{{FQDN}}';
$CONF['setup_password'] = '{{SETUP_HASH}}';

$CONF['used_quotas'] = 'YES';
$CONF['quota'] = 'YES';
$CONF['new_quota_table'] = 'YES';

?>