$(document).bind('touchmove', function(event) {
  event.preventDefault();
});

$(document).ready(function() {
  WebVRConfig = {};

  // Setup three.js WebGL renderer. Note: Antialiasing is a big performance hit.
  // Only enable it if you actually need to.
  var renderer = new THREE.WebGLRenderer({antialias: false});
  renderer.setPixelRatio(window.devicePixelRatio);

  // Append the canvas element created by the renderer to document body element.
  document.body.appendChild(renderer.domElement);

  // Create a three.js scene.
  var scene = new THREE.Scene();

  // Create a three.js camera.
  var camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 10000);

  // Apply VR headset positional data to camera.
  var controls = new THREE.VRControls(camera);

  // Apply VR stereo rendering to renderer.
  var effect = new THREE.VREffect(renderer);
  effect.setSize(window.innerWidth, window.innerHeight);


  // Add a repeating grid as a skybox.
  var boxWidth = 5;
  var loader = new THREE.TextureLoader();
  loader.crossOrigin = ''
  loader.load($('#photo-url').val(), onTextureLoaded);

  function onTextureLoaded(texture) {
    texture.wrapS = THREE.RepeatWrapping;
    texture.repeat.x = -1;
    // Used to rotate where the initial "front" is
    // texture.offset.x = (180 * Math.PI / 180) / ( 2 * Math.PI );

    var geometry = new THREE.SphereGeometry(50, 200, 200);
    var material = new THREE.MeshBasicMaterial({
      map: texture,
      side: THREE.BackSide
    });

    var skybox = new THREE.Mesh(geometry, material);
    scene.add(skybox);
  }

  // Create a VR manager helper to enter and exit VR mode.
  var params = {
    hideButton: false, // Default: false.
    isUndistorted: false // Default: false.
  };
  var manager = new WebVRManager(renderer, effect, params);

  // Request animation frame loop function
  function animate(timestamp) {
    // Update VR headset position and apply to camera.
    controls.update();

    // Render the scene through the manager.
    manager.render(scene, camera, timestamp);

    requestAnimationFrame(animate);
  }

  // Kick off animation loop
  animate();
});
