window.addEventListener('popstate', function(e) {
  location.href="/user_page";
});

document.getElementById('user_avatar').addEventListener('change', function() {
  var uploadFile = document.getElementById("user_avatar").files[0];
  var fileSize = uploadFile.size/1024/1024;
  const button = document.getElementById("submit_button");

  if (fileSize > 5) {
    alert("Maximum file size is 5MB. Please choose a smaller file.");
    button.disabled = true
  } else {
    button.disabled = false
  }

  var fileReader = new FileReader();
  fileReader.onload = (function() {
    document.getElementById('preview').src = fileReader.result;
    document.getElementById('preview').alt = uploadFile.name;
  });
  fileReader.readAsDataURL(uploadFile);
});
