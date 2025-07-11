import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:online_exam/Features/Auth/Sign_up/data/models/SignUpResponce.dart';
import 'package:online_exam/Features/Auth/Sign_up/domain/entities/SignUpEntity.dart';
import 'package:online_exam/Features/Auth/Sign_up/domain/use_cases/SignUpUseCase.dart';

part 'sign_up_state.dart';
@injectable
class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.signupusecase) : super(SignUpInitial());
  SignUpUseCase signupusecase;
  registeruser({required SignUpResponce signupresponce,
  required String firstname,
  required String secondname,
  required String username,
  required String email,
  required String phone,
  required String pass,
  required String repass})async{
    emit(SignUpLoadingState());
    var result=await signupusecase.call(signupresponce: signupresponce,
        firstname: firstname,
        secondname: secondname,
        username: username,
        email: email,
        phone: phone,
        pass: pass,
        repass: repass);
    result.fold((SignUpEntity){
      emit(SignUpSuccessState(SignUpEntity));
    },(error){
      emit(SignUpErrorState(error));
    }
    );


  }
}
