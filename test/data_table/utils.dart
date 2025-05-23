class Utils {
  static itemCheck(u1, u2, u3) {
    print(
        '\x1B[37mpage $u1 item $u2\x1B[0m \x1B[33m$u3\x1B[0m : \x1B[32msuccess\x1B[0m');
  }

  static itemSuccess(u1) {
    print('\x1B[32m$u1\x1B[0m');
  }

  static singleItemSuccess(u1) {
    print('\x1B[33m$u1\x1B[0m \x1B[32msuccess\x1B[0m');
  }

  static successTest(u1) {
    print('\x1B[35m>>>>>>>>>>>$u1\x1B[0m \x1B[32mSuccess>>>>>>>>>>>\x1B[0m');
  }

  static errorTest(u1) {
    print('\x1B[31m$u1:null in api\x1B[0m');
  }

  static String token =
      "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1IiwianRpIjoiNDkzNmRiMmMxOGE3MWM3MTlmZjQzZGFmZmUyY2E3NWViYTQ0NWMwMzVmMzNlMzYyZWQ1NDk3ZTgwN2NlZDhkMjhlZGUyNTVlODYxOWNiYjciLCJpYXQiOjE3MjEwNDQ5MDIuMzE1NDY1LCJuYmYiOjE3MjEwNDQ5MDIuMzE1NDY3LCJleHAiOjE3NTI1ODA5MDIuMzA5NDM2LCJzdWIiOiIyMzQiLCJzY29wZXMiOltdfQ.BcDxzlXjshFYTzFlfLXpYBLOa06Mo1gQQuMSlRTHBgl3SqF9mX22U9E4emjOSCGaS1HwiVc2Ql5H0KcRW9sOQd1lxj1xzyKb4Xm0Tjl54sQnt8J2hgqNaVhs4jn2JhFd6cbAFjqpovPZTjgH1qnsWe-gqAlpKzaxNnJX2ZDC2g0PjgU6nPFbQF3wiX0F9aymtAKGpIIt5JIBQ-Vi1IGbT60yeIsMvmM3X5vcD7sl3zd5w3d7ec9htIGEKdtFCKFdeZQqe43w1cQrfMRV5qKEIdXu00UHhPvpRwWEmSql5Kx1v2iJYjb9RY_-0eZfiy-55Yz8WnvpdvFSZ61-D3TAsZq1VHLhaSMFc8TqQ0uVQTwXE3QNle3HD0lGyf-2605CbaTMbLw4qKPvqjQagmuM5qlKi1hc6shz_enUFW6sSF7id1JdgehBAm1Y95nVYMhrVcfu3-jrzjL-7gKmgQrFKFIucp8a6-v-SpdJ5GYZry9_E_e5heDA7enuHq95mlAAvvYJKHYO9RH7ITCnLUv6kZ50GEiybbVolN5rA-w7iJTrIvFm_3Rt4WN-EPrIsUdWKfy42lnZZxXOkzplm4_2N-tcyFcNJJrHJRd3xJlElcj6mrTKzDYEVLzs9ZGJB-E0pFJBQxmGXCAvXflpowq03YsVtg3WzTQcT_vO4hPt79U";
}
