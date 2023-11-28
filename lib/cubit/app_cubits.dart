import 'package:bloc/bloc.dart';
import 'package:weatherapp/model/data_model.dart';
import 'package:weatherapp/services/data_services.dart';
import 'app_cubit_states.dart';

class AppCubits extends Cubit<CubitStates> {
  AppCubits({required this.data}) : super(InitialState()) {
    emit(WelcomeState());
  }

  final DataServices data;
  late final places;

  void getData() async {
    try {
      emit(LoadingState());
      places = await data.getInfo();
      print(places);
      emit(LoadedState(places: places));
    } catch (e) {}
  }

  detailPage(DataModel dataModel){
    emit(DetailState(dataModel));
  }

  goHome(){
    emit(LoadedState(places: places));
  }
}
