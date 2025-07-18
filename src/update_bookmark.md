# Updating bookmarks

We have learned how to push a new bookmark to a remote for the first time.
We _could_ do that for every single commit we create and want to push to the remote.
However, that would lead to a lot of unnecessary bookmarks lying around.
A real mess!

Thankfully, there's a better way.
Instead of creating a new bookmark every time, we can **move** an existing bookmark so it points to another commit.

To try it out, we first need to create a new commit.
You can just copy these commands:

```sh
printf "\nThis is a toy repository for learning Jujutsu.\n" >> README.md
jj describe -m "Add projcet description to readme"
jj new
```

Recall how these three commands correspond to our basic VCS-workflow:
1. make changes
1. describe the changes
1. create a new commit

There's also a neat trick here for the `describe` command:
If you already have a short message in mind, you can pass it directly with the `-m` flag (short for `--message`).
This can be faster than opening a separate text editor.

`jj log` shows us a new commit on top of the one we pushed to the remote:

<!-- generated by aha script -->
<pre class="aha">
<span class="bold "></span><span class="bold green ">@</span>  <span class="bold "></span><span class="bold highlighted purple ">k</span><span class="bold highlighted dimgray ">xvtnwxr</span><span class="bold "> </span><span class="bold yellow ">remo@buenzli.dev</span><span class="bold "> </span><span class="bold highlighted cyan ">2025-07-11 17:44:16</span><span class="bold "> </span><span class="bold highlighted blue ">a</span><span class="bold highlighted dimgray ">99737f2</span><span class="bold "></span>
│  <span class="bold "></span><span class="bold highlighted green ">(empty)</span><span class="bold "> </span><span class="bold highlighted green ">(no description set)</span><span class="bold "></span>
○  <span class="bold "></span><span class="bold purple ">t</span><span class="highlighted dimgray ">xxxnkln</span> <span class="yellow ">remo@buenzli.dev</span> <span class="cyan ">2025-07-11 17:44:16</span> <span class="green ">git_head()</span> <span class="bold "></span><span class="bold blue ">23</span><span class="highlighted dimgray ">2d89bf</span>
│  Add projcet description to readme
<span class="bold "></span><span class="bold highlighted cyan ">◆</span>  <span class="bold "></span><span class="bold purple ">o</span><span class="highlighted dimgray ">tkvqyur</span> <span class="yellow ">remo@buenzli.dev</span> <span class="cyan ">2025-07-11 17:44:04</span> <span class="purple ">main</span> <span class="bold "></span><span class="bold blue ">28</span><span class="highlighted dimgray ">bd8a65</span>
│  Add readme with project title
~
</pre>

Now we can send this new commit to the remote by first pointing the bookmark at it and then pushing the bookmark again.
Let's start by moving the bookmark:

```sh
jj bookmark move main --to @-
```

We could've told Jujutsu where to move the bookmark to using the change ID, i.e. `--to txxxnkln`.
Instead, we can use `@-`, which is a neat way to refer to the **parent of the working copy commit**.
There are many such clever ways to refer to commits, but that's a topic for later.
For now, just remember `@-`, because that's by far the most useful one.

Let's see what `jj log` has to say:

<!-- generated by aha script -->
<pre class="aha">
<span class="bold "></span><span class="bold green ">@</span>  <span class="bold "></span><span class="bold highlighted purple ">m</span><span class="bold highlighted dimgray ">yvomxzr</span><span class="bold "> </span><span class="bold yellow ">remo@buenzli.dev</span><span class="bold "> </span><span class="bold highlighted cyan ">2025-07-11 17:55:24</span><span class="bold "> </span><span class="bold highlighted blue ">5</span><span class="bold highlighted dimgray ">1b369c2</span><span class="bold "></span>
│  <span class="bold "></span><span class="bold highlighted green ">(empty)</span><span class="bold "> </span><span class="bold highlighted green ">(no description set)</span><span class="bold "></span>
○  <span class="bold "></span><span class="bold purple ">n</span><span class="highlighted dimgray ">rosmspz</span> <span class="yellow ">remo@buenzli.dev</span> <span class="cyan ">2025-07-11 17:55:24</span> <span class="purple ">main*</span> <span class="green ">git_head()</span> <span class="bold "></span><span class="bold blue ">c</span><span class="highlighted dimgray ">59322ad</span>
│  Add projcet description to readme
<span class="bold "></span><span class="bold highlighted cyan ">◆</span>  <span class="bold "></span><span class="bold purple ">q</span><span class="highlighted dimgray ">tzssony</span> <span class="yellow ">remo@buenzli.dev</span> <span class="cyan ">2025-07-11 17:55:14</span> <span class="purple ">main@origin</span> <span class="bold "></span><span class="bold blue ">3</span><span class="highlighted dimgray ">812d571</span>
│  Add readme with project title
~
</pre>

The important thing to notice here is that Jujutsu shows us the discrepancy between the local bookmark `main` and its remote counterpart.
`main*` is the local bookmark and the star next to its name means it's out-of-sync with the remote.
`main@origin` is the location of the bookmark on the remote.

We can fix the situation by pushing the bookmark again:

```sh
jj git push
```

This time, we didn't specify `--bookmark main` explicitly.
If you omit the `--bookmark` flag on the `push` command, Jujutsu tries to be smart about which bookmarks you actually want to push.
That usually works quite well.
If you think it didn't work, just try again with the `--bookmark` flag.

You might be wondering:
Since the remote requires a bookmark to receive commits and the `main` bookmark is **not** pointing to the first commit anymore... is that commit now lost or deleted?
Luckily it is not.
Commits store a reference to their parent commit, which is why Jujutsu knows the order in which to draw the commits in the output of `jj log`.
When a bookmark is pushed to a remote, the commit it points to is sent **along with all its ancestors**.
The remote knows that it shouldn't delete any ancestors of commits with bookmarks pointing to them.

```admonish success title="You've completed Level 0 ! 🎉"
You made it!
At this point, you have all the skills needed for simple solo projects with proper backup.
Let's summarize the workflow again:
1. make changes
1. describe the changes
1. create a new commit
1. move the bookmark
1. push to the remote

Ideally, you can take a little break now and practice what you've learned.
Once you feel comfortable with the above, come back quickly for level 1, we're just scratching the surface.

If you need to collaborate with other people, level 1 is just as essential as this one.
I encourage you keep going right away!
You've earned yourself a quick bathroom break though.
```
