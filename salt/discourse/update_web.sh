# 
# Script to update Discourse while preserving the symlinks
# 
# The launcher will attempt to recreate them as directories, so we need to move
# them aside, then delete the newly created empty directories
# 

cd /srv/discourse

mv shared/web/backups{,_}
mv shared/web/uploads{,_}

./launcher rebuild web

rmdir shared/web/backups shared/web/uploads
mv shared/web/backups{_,}
mv shared/web/uploads{_,}
