import 'package:cleancode_app/features/home/data/models/menu_response_model.dart';
import 'package:cleancode_app/features/home/domain/entities/module.dart';
import 'package:cleancode_app/features/home/domain/usecases/get_modules_usecase.dart';
import 'package:cleancode_app/features/home/presentation/bloc/module_state.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModuleCubit extends Cubit<ModuleState> {
  
  ModuleCubit(): super(ModuleLoadingState());

  void getModules() async {
    await Future.delayed(Duration(seconds: 1));

    var result = await sl<GetModulesUsecase>().call(
      params: ''
    );

    result.fold((
      error) {
        if (!isClosed) {
          emit(ModuleFailureState(errorMessage: error));
        }
      }, 
      (data) {
        final res = MenuResponse.fromMap(data);
        final List<Module> modules = [];
        for (var element in res.data as List) {
          modules.add(element.module);
        }
        
        emit(ModuleSuccessState(modules));
      },
    );
  }

}