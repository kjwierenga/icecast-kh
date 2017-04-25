# XIPH_NET
# Perform tests required by the net module
AC_DEFUN([XIPH_NET],
[dnl
AC_REQUIRE([XIPH_TYPE_SOCKLEN_T])
AC_REQUIRE([XIPH_FUNC_VA_COPY])
AC_CHECK_HEADERS([sys/select.h sys/uio.h netinet/in.h netinet/tcp.h arpa/inet.h netdb.h])
AC_MSG_CHECKING([for winsock2.h inclusion])
if test "x$host_os" = "xmingw32"; then
   AC_DEFINE([HAVE_WINSOCK2_H], [1], [Define if you have winsock2.h on MINGW])
   AC_DEFINE([_WIN32_WINNT], [0x0501], [Define for IPv6 on win32])
   AC_DEFINE([HAVE_GETNAMEINFO])
   AC_DEFINE([HAVE_GETADDRINFO])
   ac_cv_search_getnameinfo='none required'
   ac_cv_func_getaddrinfo=yes
   XIPH_LIBS="$XIPH_LIBS -lws2_32 -lwsock32"
   AC_MSG_RESULT([yes])
else
   AC_MSG_RESULT([no])
fi

# These tests are ordered based on solaris 8 tests
AC_SEARCH_LIBS([sethostent], [nsl],
  [AC_DEFINE([HAVE_SETHOSTENT], [1],
    [Define if you have the sethostent function])])
AC_SEARCH_LIBS([getnameinfo], [socket],
  [AC_DEFINE([HAVE_GETNAMEINFO], [1],
    [Define if you have the getnameinfo function])
  ])
AC_CHECK_FUNCS([endhostent getaddrinfo inet_aton writev])

# Irix defines INET_PTON but not sockaddr_storage!
AC_CHECK_MEMBERS([struct sockaddr_storage.ss_family],
  [AC_CHECK_FUNCS([inet_pton])],,
  [#include <sys/types.h> 
#include <sys/socket.h>])
])
