window.addEventListener('popstate', function(e) {
  location.href="/edit";
});

document.getElementById('user_image').addEventListener('change', function() {
  console.log('Hello world!')
  var uploadFile = document.getElementById("user_image").files[0];
  var fileSize = uploadFile.size/1024/1024
  if (fileSize > 5) {
    alert("Maximum file size is 5MB. Please choose a smaller file.");
  }
  document.getElementById("result").innerHTML = fileSize;

  var fileReader = new FileReader();
  fileReader.onload = (function() {
    document.getElementById('preview').src = fileReader.result;
  });
  fileReader.readAsDataURL(uploadFile);
});
