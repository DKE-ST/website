if [ -z "$1" ]; then
  echo "Usage: ./newPlugin.sh PLUGIN_NAME"
  exit 0
fi
if echo $1 | grep -qE '\.'; then
  echo "Invalid plugin name"
  exit 0
fi
rails plugin new plugins/$1 --full --skip-test-unit --database=mysql --template=plugins/.gemTemplate.rb

cd $1
rails generate rspec:install
