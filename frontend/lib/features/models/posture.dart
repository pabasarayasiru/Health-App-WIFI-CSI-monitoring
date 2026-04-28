enum Posture {
  prone,
  left,
  right,
  supine,
  unknown,
}

Posture postureFromString(String? value) {
  switch (value) {
    case "prone":
      return Posture.prone;
    case "left":
      return Posture.left;
    case "right":
      return Posture.right;
    case "supine":
      return Posture.supine;
    default:
      return Posture.unknown;
  }
}

String postureToString(Posture posture) {
  return posture.name;
}