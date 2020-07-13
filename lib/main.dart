import 'package:Product_Catalog/screens/CategoryProductScreen.dart';
import 'package:Product_Catalog/screens/CategoryScreenHor.dart';
import 'package:Product_Catalog/screens/FeaturedScreen.dart';
import 'package:Product_Catalog/screens/Home.dart';
import 'package:Product_Catalog/screens/TrendingScreen.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:Product_Catalog/screens/CategoryScreenVert.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Declaring Auth Variables
  AuthLink authLink;
  HttpLink httpLink;
  // Declaring GraphQLClient for connection
  ValueNotifier<GraphQLClient> client;


  @override
  void initState() {
    super.initState();
    // Setting up network with GraphQL Server
    authLink = AuthLink(
        getToken: () async =>
            'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ik0wTTNOVVV3UmpVNU0wSkZRalpDUkRsQ05URTNOVFk1T0RnME5EaEJNVGRDTUVORU1EQkNOZyJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWRlZmF1bHQtcm9sZSI6InVzZXIiLCJ4LWhhc3VyYS1hbGxvd2VkLXJvbGVzIjpbInVzZXIiXSwieC1oYXN1cmEtdXNlci1pZCI6Imdvb2dsZS1vYXV0aDJ8MTA3MDg2ODczMzI3NDk4MTQ3ODI4In0sImdpdmVuX25hbWUiOiJBcHVydmEiLCJmYW1pbHlfbmFtZSI6Ikp1bmdhZGUiLCJuaWNrbmFtZSI6ImFwdXJ2YWp1bmdhZGVha2wiLCJuYW1lIjoiQXB1cnZhIEp1bmdhZGUiLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDQuZ29vZ2xldXNlcmNvbnRlbnQuY29tLy1vd2dmN19IdUJLdy9BQUFBQUFBQUFBSS9BQUFBQUFBQUFBQS9BTVp1dWNtb3ZqTjljWTdEeWFKcFhwQXUxN0s4X2NRMHV3L3Bob3RvLmpwZyIsImxvY2FsZSI6ImVuLUdCIiwidXBkYXRlZF9hdCI6IjIwMjAtMDYtMzBUMDg6MjE6NTYuNTQ2WiIsImlzcyI6Imh0dHBzOi8vZ2VuZXNpc3BvcnRhbC5hdXRoMC5jb20vIiwic3ViIjoiZ29vZ2xlLW9hdXRoMnwxMDcwODY4NzMzMjc0OTgxNDc4MjgiLCJhdWQiOiJBS2wwNnc1REpPeWtpZ1dmSVZnUkt0TjQ1Zzc0MjMxQyIsImlhdCI6MTU5MzUwNTMxNiwiZXhwIjoxMTE5MzUwNTMxNCwiYXRfaGFzaCI6Inp1M0VRY3ZzRmViUmxDaGZxNUppd0EiLCJub25jZSI6ImxSUzRpS2ptaUJoVjNUdUItX2laWlpiR0pZLnN5ZnExIn0.DLKDe9LcSk20CPyv1jLHoMl2k_o7F-_j-KFCdh35ZP2ZNyjXNwZOnLwnGJ07b2yGuubPorKah2ryosqsdvWnA3wot9YSN6lO5JIEoTL8X6KA5WEezu_NXVZ2hhFBn27gtaNAAK3_n4bcb_tPe12-3Ec3J79-XEDIaDHzE-2HXTDfP1kNnL-lhg8UdSbheBnkgvK_uQFVhZDloGrXVbmEOciUab7wXZC3dQGBWiShKKnqA01Tnmiw_RaQK6oXYZ8ORNiymv-YTZXtG2csZfBX3BjFSJpSUaGF9-efsGYAVnJH0BhlgWsiGXC5eedHT8UPMZWVN7UHi0yQLYRpVQjpgw',
            );
    httpLink =
        HttpLink(uri: 'https://definite-rabbit-51.hasura.app/v1/graphql');
    Link link = authLink.concat(httpLink);
    client = ValueNotifier(
      GraphQLClient(link: link, cache: InMemoryCache())
      );
  }
  @override
  Widget build(BuildContext context) {
    
    // GraphQLProvider provides access to client instance down the widget tree
    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: MaterialApp(
          title: 'Flutter & GraphQL Demo App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Home()
        ),
      ),
    );
  }
}