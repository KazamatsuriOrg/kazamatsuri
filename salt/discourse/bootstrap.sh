config=$1

# Shamelessly stolen from Discourse's normal launcher
# Checks if the specified container is already running
existing=`$docker_path ps | awk '{ print $1, $(NF) }' | grep " $config$" | awk '{ print $1 }'`
if [ ! -z $existing ]; then
	exit 0
fi

./launcher bootstrap $config
