--open db
.open smash.db
--wipe it clean
.read ./mgmt/1-drop-tables.sql
--recreate tables
.read ./mgmt/2-create-tables.sql
--import data
.read ./mgmt/3-import-csvs.sql