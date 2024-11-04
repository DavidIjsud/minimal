import 'package:dartz/dartz.dart';

import '../models/clients.dart';

abstract class ClientRepository {
  Future<Either<Fail, List<Client>>> getClients();
  Future<Either<Fail, bool>> addClient(Client client);
  Future<Either<Fail, bool>> updateClient(Client client);
  Future<Either<Fail, bool>> removeClient(String clientId);
}
