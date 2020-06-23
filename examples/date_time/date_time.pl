use POSIX qw(strftime);
print(strftime("%Y/%m/%d %H:%M:%S", localtime())."\n");
