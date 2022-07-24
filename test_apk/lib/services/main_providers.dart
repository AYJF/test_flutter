import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:test_apk/core/auth/auth_provider.dart';

import 'package:test_apk/core/models/auth_user_model.dart';
import 'package:test_apk/models/client_model.dart';
import 'package:test_apk/services/fs_service.dart';

final List<SingleChildWidget> mainProviders = [
  // StreamProvider<List<ClientModelNew>>(
  //   initialData: null,
  //   create: (_) {
  //     return FSHelper<ClientModelNew>('clients').streamDocs(
  //       (json, {docId}) {
  //         return ClientModelNew.fromMap(json, docId: docId);
  //       },
  //     );
  //   },
  //   catchError: (_, error) {
  //     print("Client Model error: ${error.toString()}");
  //     return [ClientModelNew.empty];
  //   },
  //   //this code about email table add by Yeisa.
  // ),
  ChangeNotifierProvider<AuthProvider>(
    create: (context) => AuthProvider(context),
  ),
  StreamProvider<ClientModel?>(
    initialData: null,
    create: (context) => DatabaseService<ClientModel>(collection: 'users')
        .findFirstValue('email', context.read<AuthUserModel>().email,
            (json) => ClientModel.fromJson(json)),
    catchError: (_, err) {
      print("User erorrs");
      print(err.toString());
      return ClientModel.empty;
    },
  ),
  // StreamProvider<ProjectModel>(
  //   initialData: null,
  //   create: (context) => DatabaseService<ProjectModel>(collection: 'project')
  //       .findFirstValue('project_id', context.read<ClientModelNew>().projectId,
  //           (json) => ProjectModel.fromJson(json)),
  //   catchError: (_, error) {
  //     print("Project Model error: ${error.toString()}");
  //     return ProjectModel.empty;
  //   },
  // ),
  // StreamProvider<List<PerceelModel>>(
  //   initialData: null,
  //   create: (context) => DatabaseService<PerceelModel>(collection: 'perceel')
  //       .getRowsByOne('contact_id', context.read<ClientModelNew>().id,
  //           (json) => PerceelModel.fromJson(json)),
  //   catchError: (_, err) {
  //     return [PerceelModel.empty];
  //   },
  // ),
  // StreamProvider<List<FactuurModel>>(
  //   initialData: null,
  //   create: (context) => DatabaseService<FactuurModel>(collection: 'factuur')
  //       .getRowsByOne('contact_id', context.read<ClientModelNew>().id,
  //           (json) => FactuurModel.fromJson(json)),
  //   catchError: (_, err) {
  //     return [FactuurModel.empty];
  //   },
  // ),
  // StreamProvider<List<ContactPdfModel>>(
  //   initialData: null,
  //   create: (context) =>
  //       DatabaseService<ContactPdfModel>(collection: 'contract_pdf')
  //           .getRowsByOne('contact_id', context.read<ClientModelNew>().id,
  //               (json) => ContactPdfModel.fromJson(json)),
  //   catchError: (_, error) {
  //     print("Project Model error: ${error.toString()}");
  //     return [];
  //   },
  // ),
  // StreamProvider<List<VoorschotModel>>(
  //   initialData: null,
  //   create: (context) =>
  //       DatabaseService<VoorschotModel>(collection: 'voorschot').getRowsByOne(
  //           'contact_id',
  //           context.read<ClientModelNew>().id,
  //           (json) => VoorschotModel.fromJson(json)),
  //   catchError: (_, error) {
  //     print("VoorschotModel error: ${error.toString()}");
  //     return [];
  //   },
  // ),

  // ChangeNotifierProvider<HomeHandler>(
  //   create: (context) => HomeHandler(),
  // ),
  // StreamProvider<List<InbuildingGroupModel>>(
  //   initialData: null,
  //   create: (context) =>
  //       DatabaseService<InbuildingGroupModel>(collection: 'perceel')
  //           .getRowsByOne('contact_id', context.read<ClientModelNew>().id,
  //               (json) => InbuildingGroupModel.fromJson(json)),
  //   catchError: (_, err) {
  //     return <InbuildingGroupModel>[];
  //   },
  // ),
  // ChangeNotifierProvider<SettingsProvider>(
  //   create: (context) => SettingsProvider(context: context),
  // ),
  // FutureProvider<ImagesModel>(
  //   create: (context) => _donwloadImages(context.read<ProjectModel>().foto),
  //   initialData: null,
  //   catchError: (_, error) {
  //     print(error.toString());
  //     return null;
  //   },
  // ),

  // // StreamProvider<List<ValvesGroupScheduleModel>>(
  // //   initialData: null,
  // //   create: (context) =>
  // //       DatabaseService<ValvesGroupScheduleModel>(collection: 'perceel')
  // //           .getRowsByOne('contact_id', context.read<ClientModelNew>().id,
  // //               (json) => ValvesGroupScheduleModel.fromJson(json)),
  // //   catchError: (_, err) {
  // //     return <ValvesGroupScheduleModel>[];
  // //   },
  // // ),
];
