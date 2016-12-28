# ambari_setting_updater

Updating every setting in ambari takes forever. This is very basic (sort of dirty) script which just reads the CSV file for service, setting and its value. Based on that, it updates ambari
programatically.

After all updates are done, you can restart-all-needed from ambari-ui.

E.g: sh tune.sh settings.csv localhost admin admin 8080 benchmarkcluster
