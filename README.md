# Cloudupdate

*Cloudupdate* is a script our team uses to run a series of update and package cleanup tasks on a [Debian](https://www.debian.org/) or [Ubuntu](https://ubuntu.com/server) server instance in local development or staging environments.

## About the Script

We wrote this as a simple way to automate apt (and nala) tasks to keep packages up-to-date in non-production, development, or staging environments where other toolkits wouldn't fit.

## How to use this script

- Clone the repository using the command `git clone https://github.com/galiemedia/cloudupdate.git`
- Switch into the cloned directory using `cd ./cloudupdate/`
- Remember to make the script executable with `chmod +x cloudupdate.sh`

## License

*Cloudsetup* is released under the [MIT License](https://opensource.org/licenses/MIT).