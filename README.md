Contestify
=====

This is a simple ruby gem to automate the process of setting up a programming contest with [DOMJudge](http://domjudge.sourceforge.net/). You can choose from several judges and the problems will be uploaded without too much work, because, let's be honest, DOMJudge is a great online judge, but it sucks at UI.

Install
---

Installing Contestify couldn't be easier. Just type

  gem install contestify

Then, you can run `contestify check` to check the OS dependencies. Most Unix systems _should_ have the dependencies installed.

Usage & Help
---

You can run the `contestify` command with no arguments to see the available judges. Each available judge will ask for different arguments. If you need help with a specific judge, you can type `contestify help <judge>` and it will give you some help about it.

```
  contestify help coci
```

Provide the requested data for each judge and it should run smoothly. It is important to notice that Contestify **DOES NOT** store **ANY** data. It asks for passwords just to be able to upload (and sometimes fetch) the problems. If you still doubt it, you can check the code for yourself.


Notes
---

* Contestify **will not** create a new contest. Just add problems to the current one. So you'll need to have an active contest to run this.

* It is assumed that the **Admin username** is `admin`.

Fast Example
----

```
contestify coci http://hsin.hr/coci/contest1_testdata.zip http://juez.factorcomun.org/jury/problem.php p4ssw0rd
```

Contributions
---

If you find any bug or have any addition, please let us know. You can use the [issue tracker](https://github.com/nhocki/contestify/issues) for that.

We would also love to have more and more judges, so if you want to write one, just submit a pull request with it.