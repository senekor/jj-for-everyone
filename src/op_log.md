# Undoing mistakes

```admonish tip title="Welcome to level 2 !" 
If you took a break after finishing level 0, remember that you can [restore your progress](./introduction.md#restoring-your-progress) in the example repo in case you lost it.

In the previous level, we had lots of fun role-playing as Alice and Bob.
I think it was important to think clearly in terms of multiple people working on the same thing, at the same time.
From now on, we'll drop the role-play.
You already have an intuition about how independent, distributed collaboration can exacerbate the challenges we're about to discuss.
```

What we've learned so far can go a long way - until something goes wrong.
For example, assume you finished working on a commit by running `jj new`.
Shortly afterwards, you realize that you forgot to give the commit a good description!
If your peers care about good commit descriptions, they might get annoyed with you if that commit lands on the main branch.

With our current skill set, it's impossible to edit the description of a commit after we ran `jj new`.
But what if we could simply **undo** our mistakes?
Travel back in time?
Turns out we can, because Jujutsu stores not only a version history of our project in the form of commits, but it also keeps a log of all operations that were performed on the repository.
This is aptly named the **operation log**.
Several commands related to it are available via `jj op`.

## op log

First of all, let's get a feel of this operation log by taking a look at it.
We can display it by running `jj op log`:



## op undo

## op restore

## op undo $op-id
