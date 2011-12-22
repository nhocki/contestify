Contestify::Local
===

This strategy will upload the problems from a local directory to the server. Usage:

    contestify local problem_url judge_upload_url judge_admin_password

Note that the Judge URL is the actual **upload** URL, which is normally `http://you-dom-judge.com/jury/problem.php`.

Here's an example of usage with _real_ data:

    contestify /tmp/my_test_data http://domjudge.factorcomun.org/jury/problem.php p4ssw0rd

This will get the problems in `/tmp/my_test_data` and add them to DOMjudge on the server.

`/tmp/my_test_data` should contain a directory for every problem and each directory should
contain the input and output files for the problem. The files should be named `something.in`
and `something.out`, respectively. So if you want to add several test files for a problem
named `Example` the files inside `/tmp/my_test_data/example` would look like this: `example.1.in, example.1.out, example.2.in, example.2.out`.