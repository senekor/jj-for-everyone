#!/usr/bin/env bash
set -euo pipefail

if [ "${1:-x}" = "x" ] ; then
    echo "Please provide the number of your last completed chapter as the first argument."
    exit 1
fi
chapter="$1"

function success() {
    echo "Script completed successfully."
    exit 0
}

rm -rf ~/jj-tutorial
rm -rf ~/jj-tutorial-remote
rm -rf ~/jj-tutorial-bob

if [ "$chapter" = 1 ] ; then success ; fi

mkdir ~/jj-tutorial
cd ~/jj-tutorial
jj git init --colocate --quiet

if [ "$chapter" = 2 ] ; then success ; fi

if [ "$chapter" = 3 ] ; then success ; fi

echo "# jj-tutorial" > README.md
jj log -r 'none()' # trigger snapshot

if [ "$chapter" = 4 ] ; then success ; fi

jj describe --quiet --message "Add readme with project title

It's common practice for software projects to include a file called
README.md in the root directory of their source code repository. As the
file extension indicates, the content is usually written in markdown,
where the title of the document is written on the first line with a
prefixed \`#\` symbol.
"

if [ "$chapter" = 5 ] ; then success ; fi

jj new --quiet

if [ "$chapter" = 6 ] ; then success ; fi

mkdir ~/jj-tutorial-remote
cd ~/jj-tutorial-remote
git init --bare --quiet
cd ~/jj-tutorial
jj git remote add origin ~/jj-tutorial-remote
jj bookmark create main --revision @- --quiet
jj git push --bookmark main --quiet
cd ~
rm -rf ~/jj-tutorial
jj git clone --colocate ~/jj-tutorial-remote ~/jj-tutorial --quiet
cd ~/jj-tutorial

if [ "$chapter" = 7 ] ; then success ; fi

printf "\nThis is a toy repository for learning Jujutsu.\n" >> README.md
jj describe -m "Add project description to readme" --quiet
jj new --quiet

jj bookmark move main --to @- --quiet

jj git push --quiet

if [ "$chapter" = 8 ] ; then success ; fi

jj config set --repo user.name Alice 2> /dev/null
jj config set --repo user.email alice@local 2> /dev/null
jj describe --reset-author --no-edit --quiet

echo "print('Hello, world!')" > hello.py

jj describe -m "Add Python script for greeting the world

Printing the text \"Hello, world!\" is a classic exercise in introductory
programming courses. It's easy to complete in basically any language and
makes students feel accomplished and curious for more at the same time." --quiet

jj new --quiet

jj git clone --colocate ~/jj-tutorial-remote ~/jj-tutorial-bob --quiet
cd ~/jj-tutorial-bob
jj config set --repo user.name Bob 2> /dev/null
jj config set --repo user.email bob@local 2> /dev/null
jj describe --reset-author --no-edit --quiet

echo "# jj-tutorial

The file hello.py contains a script that greets the world.
It can be executed with the command 'python hello.py'.
Programming is fun!" > README.md
jj describe -m "Document hello.py in README.md

The file hello.py doesn't exist yet, because Alice is working on that.
Once our changes are combined, this documentation will be accurate." --quiet
jj new --quiet

jj bookmark move main --to @- --quiet
jj git push --quiet

cd ~/jj-tutorial
jj bookmark move main --to @- --quiet
jj git fetch --quiet

if [ "$chapter" = 9 ] ; then success ; fi

if [ "$chapter" = 10 ] ; then success ; fi

jj new main@origin @- --quiet

jj describe -m "Combine code and documentation for hello-world" --quiet
jj new --quiet
jj bookmark move main --to @- --quiet
jj git push --quiet

if [ "$chapter" = 11 ] ; then success ; fi

cd ~/jj-tutorial-bob

tar czf submission_alice_bob.tar.gz README.md

echo "
## Submission

Run the following command to create the submission tarball:

~~~sh
tar czf submission_alice_bob.tar.gz [FILE...]
~~~" >> README.md

jj describe -m "Add submission instructions" --quiet

echo "*.tar.gz" > .gitignore

jj file untrack submission_alice_bob.tar.gz

if [ "$chapter" = 12 ] ; then success ; fi

jj new --quiet
jj bookmark move main --to @- --quiet
jj git fetch --quiet
jj rebase --destination main@origin --quiet
jj git push --quiet

if [ "$chapter" = 13 ] ; then success ; fi

cd ~/jj-tutorial

echo "
for (i = 0; i < 10; i = i + 1):
    print('Hello, world!')" >> hello.py

jj describe -m "WIP add for loop (need to fix syntax)" --quiet
jj new --quiet

jj git push --change @- --quiet

jj git fetch --quiet
jj new main --quiet

if [ "$chapter" = 14 ] ; then success ; fi

echo "Error: unrecognized chapter."
exit 1
