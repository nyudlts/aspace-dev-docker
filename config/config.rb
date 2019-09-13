# You can override the default configuration options by setting them here.
# For example, something like like this if you want to use MySQL:

AppConfig[:db_url] = "jdbc:mysql://mysql/archivesspace?useUnicode=true&characterEncoding=UTF-8&user=archivesspace&password=archivesspace"

AppConfig[:plugins] = ['nyu_marcxml_export_plugin', 'nyu_ead_export_plugin', 'nyu_sso_plugin', 'digitization_work_order_plugin']
