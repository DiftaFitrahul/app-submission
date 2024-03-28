double yAlignmentPickLocationSlidingUp(double screenHeight) {
  switch (screenHeight) {
    case < 700:
      return 1.7;
    case < 800:
      return 1.63;
    case < 850:
      return 1.51;
    case < 900:
      return 1.46;
    case < 950:
      return 1.44;
    default:
      return 1.43;
  }
}

double yAlignmentDetailStorySlidingUp(double screenHeight) {
  switch (screenHeight) {
    case < 500:
      return 4;
    case < 700:
      return 3.5;
    case < 800:
      return 3.1;
    case < 850:
      return 2.6;
    case < 900:
      return 2.38;
    case < 950:
      return 2.24;
    default:
      return 2.2;
  }
}
