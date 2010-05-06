#!/bin/sh

ssh deployer@help-me-hackers.com "mysqldump -uroot help-me-hackers_production > /tmp/dump.sql"
scp deployer@help-me-hackers.com:/tmp/dump.sql .                                                                                           [~]
mysql -uroot help-me-hackers_development < dump.sql                                                                                        [~]
ssh deployer@help-me-hackers.com "rm -f /tmp/dump.sql"                                                                                     [~]
rm dump.sql
