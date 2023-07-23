abstract class NeuroStates {}

class NeuroInitialState extends NeuroStates {}

class NeuroBottomNavState extends NeuroStates {}

class NeuroGetPatientSuccessState extends NeuroStates {}

class NeuroGetPatientLoadingState extends NeuroStates {}

class NeuroGetPatientErrorState extends NeuroStates {

  late final String error ;

  NeuroGetPatientErrorState (this.error);

}




class NeuroGetDownloadSuccessState extends NeuroStates {}

class NeuroGetDownloadLoadingState extends NeuroStates {}

class NeuroGetDownloadErrorState extends NeuroStates {

  late final String error ;

  NeuroGetDownloadErrorState (this.error);

}

