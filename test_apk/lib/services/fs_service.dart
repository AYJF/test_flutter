import 'package:cloud_firestore/cloud_firestore.dart';

//TODO:(Alvaro) improve this class

/// Class T implementation for using whit all models class.
class DatabaseService<T> {
  final String? collection;
  final db = FirebaseFirestore.instance;

  DatabaseService({this.collection});

  /// Get rows by two where conditions.
  /// Return rows as list<model>
  Stream<List<T>> getRowsByTwo(
    String field1,
    var val1,
    String field2,
    var val2,
    Function(Map<String, dynamic> json) fromJson,
  ) {
    final Query res = db
        .collection(collection!)
        .where(field1, isEqualTo: val1)
        .where(field2, isEqualTo: val2);

    return res.snapshots().map<List<T>>((event) => event.docs
        .map<T>(
          (e) => fromJson(e.data() as Map<String, dynamic>),
        )
        .toList());
  }

  /// Get rows by one where conditions.
  /// Return rows as list<model>
  Stream<List<T>> getRowsByOne(
      String field, var val, Function(Map<String, dynamic> json) fromJson) {
    final Query res = db.collection(collection!).where(field, isEqualTo: val);

    return res.snapshots().map<List<T>>((event) => event.docs
        .map<T>(
          (e) => fromJson(
            e.data() as Map<String, dynamic>,
          ),
        )
        .toList());
  }

  /// Get rows by one where conditions.
  /// Return rows as list<model>
  Stream<T> getRow(
      String field, var val, Function(Map<String, dynamic> json) fromJson) {
    final Query res =
        db.collection(collection!).where(field, isEqualTo: val).limit(1);

    return res.snapshots().map<T>((event) => event.docs
        .map<T>((e) => fromJson(e.data() as Map<String, dynamic>))
        .toList()
        .first);
  }

  /// Get rows by one where conditions.
  /// Return rows as list<model>
  Stream<List<T>> getRowsOrderBy(
      String field, int limit, Function(Map<String, dynamic> json) fromJson) {
    final Query res = db
        .collection(collection!)
        .orderBy(field, descending: true)
        .limit(limit);

    return res.snapshots().map<List<T>>((event) => event.docs
        .map<T>(
          (e) => fromJson(
            e.data() as Map<String, dynamic>,
          ),
        )
        .toList());
  }

  Stream<List<T>> getRowsByWhereIn(
      String field, List val, Function(Map<String, dynamic> json) fromJson) {
    final Query res = db.collection(collection!).where(field, whereIn: val);

    return res.snapshots().map<List<T>>((event) => event.docs
        .map<T>((e) => fromJson(e.data() as Map<String, dynamic>))
        .toList());
  }

  /// Get rows by one where conditions.
  /// Return rows as list<model> (i hadn't tested it yet)
  Stream<List<T>> getRowsByOneArray(
      String field, val, Function(Map<String, dynamic> json) fromJson) {
    final Query res =
        db.collection(collection!).where(field, arrayContainsAny: val);

    return res.snapshots().map<List<T>>((event) => event.docs
        .map<T>(
          (e) => fromJson(
            e.data() as Map<String, dynamic>,
          ),
        )
        .toList());
  }

  // Add a new document
  Future<void>? addDocument(Map<String, dynamic> model) {
    db
        .collection(collection!)
        .add(model)
        .then((value) => "Doc added Successfully!")
        .catchError((error) => "Failed to add Doc, error: $error ");
    return null;
  }

  Future<T> findOneDocwhere(
      String field, var val, T Function(Map<String, dynamic> json) fromJson) {
    final res =
        db.collection(collection!).where(field, isEqualTo: val).limit(1).get();

    return res.then<T>((event) => event.docs
        .map<T>(
          (e) => fromJson(e.data()),
        )
        .first);
  }

  Future<T> findOneDocwhere2(String field, var val, String field2, var val2,
      T Function(Map<String, dynamic> json) fromJson) {
    final res = db
        .collection(collection!)
        .where(field, isEqualTo: val)
        .where(field2, isEqualTo: val2)
        .limit(1)
        .get();

    return res
        .then<T>((event) => event.docs.map<T>((e) => fromJson(e.data())).first);
  }

  Future<List<T>> findAllDocwhere(
      String field, var val, Function(Map<String, dynamic> json) fromJson) {
    final res = db.collection(collection!).where(field, isEqualTo: val).get();

    return res.then<List<T>>((event) => event.docs
        .map<T>(
          (e) => fromJson(
            e.data(),
          ),
        )
        .toList());
  }

  // Update doc
  Future<void> updateDoc(
      Map<String, dynamic> model, String field, var val) async {
    db
        .collection(collection!)
        .doc(await getDocIdBy(field, val))
        .update(model)
        .then((value) => "Doc Updated Successfully!!")
        .catchError((error) => "Failed to update doc, error: $error");
  }

  Future<void> updateDocById(Map<String, dynamic> model, uid) async {
    return await db.collection(collection!).doc(uid).set(model);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocById(String id) async {
    return await db.collection(collection!).doc(id).get();
  }

  // Get doc by field
  Future<String> getDocIdBy(String field, var val) {
    final Query res =
        db.collection(collection!).where(field, isEqualTo: val).limit(1);

    return res.get().then((value) => value.docs.first.id);
  }

  //add documents with especifiq id
  Future<void>? addDocumentWithID(Map<String, dynamic> model, String id) {
    db
        .collection(collection!)
        .doc(id)
        .set(model)
        .then((value) => "Doc added Successfully!")
        .catchError((error) => "Failed to add Doc, error: $error ");

    return null;
  }

  Future<void> deleteDocWhere(String field, var val) async {
    await db
        .collection(collection!)
        .where(field, isEqualTo: val)
        .limit(1)
        .get()
        .then(
          (value) => value.docs.forEach(
            //TODO:(Alvaro) avoid foreach loop
            (e) {
              e.reference.delete();
            },
          ),
        );
  }

  /// Find first occurrence of the value (val) for the field (field).
  /// Return only one row.
  Stream<T> findFirstValue(
      String field, var val, T Function(Map<String, dynamic> json) fromJson) {
    final res = db
        .collection(collection!)
        .where(field, isEqualTo: val)
        .limit(1)
        .snapshots();

    return res.map<T>((event) => event.docs
        .map<T>(
          (e) => fromJson(
            e.data(),
          ),
        )
        .toList()
        .first);
  }

  /// Test
  /// Get the whole table in form of list (list<>).
  /// Return list<T>
  Stream<List<T>> getListTable(Function(Map<String, dynamic> json) fromJson) {
    final res = db.collection(collection!).snapshots();
    return res.map<List<T>>((event) => event.docs
        .map<T>(
          (e) => fromJson(
            e.data(),
          ),
        )
        .toList());
  }
}
