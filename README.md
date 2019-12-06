# fpscontroller
First Person Controller for Godot

<b>Search on godot assetlib for this plugin/addon</b>

<h2>First Person Controller for Godot Engine</h2>
<p>This is a shortcut tool for setting up a first person player (specially for FPS games). Just install the asset in godot asset library
and drag the FpsController.tscn file from project pane to scene window. This creates the first person player. You may need to delete camera's
that you previously have made. <b style="color:red">Don't delete the camera of this scene</b>

<p>You can set an object being held by the player, such as a gun or flashlight or what ever, by creating a Spatial node as a child of the FpsController. Then set the FpsController's property <b>HeldObject</b> to the Node containing your item. Your item will now follow your camera's rotation as you look around.</p>

<h2>Properties</h2>
<b>Sensitivity X</b>
<dd>Horizontal Sensitivity of Mouse</dd>
<b>Sensitivity Y</b>
<dd>Vertical Sensitivity of Mouse</dd>
<b>Invert Y Axis</b>
<dd>If you move the mouse down camera will rotate upward if checked</dd>
<b>Exit on Escape</b>
<dd>Pressing on Escape will cause the game to quit. It is helpful while debugging but not recommended for production. If this is false, then hitting escape will stop the mouse form being captured. You can re-capture the mouse buy hitting escape again, or refocusing the window.</dd>
<b>Maximum Y Look</b>
<dd>Maximum angle in degress you can look upward and downward</dd>
<b>Sprint Accelaration</b>
<dd>Accelaration of Sprint Speed</dd>
<b>Maximum Sprint Speed</b>
<dd>Maximum speed the player can sprint.</dd>
<b>Walking Accelaration</b>
<dd>Accelaration of Walk Speed</dd>
<b>Maximum Walk Speed</b>
<dd>Maximum speed the player can walk.</dd>
<b>Jump Speed</b>
<dd>Hope there's no need to explain</dd>
<b>Held Object</b>
<dd>The path to a child Node of FpsController that contains the object you wish the player to be holding.</dd>