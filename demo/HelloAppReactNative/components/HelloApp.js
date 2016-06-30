import React,  {
  Component,
  StyleSheet,
  View,
  Text,
  TouchableHighlight,
  NativeModules,
  NativeAppEventEmitter
} from 'react-native';

var LyricsManager = NativeModules.LyricsManager;

class HelloApp extends Component {
  constructor(props) {
    super(props);

    this.state = {lyric: '<Start Singing>'}

    this._onNextLyric = this._onNextLyric.bind(this);

    this.subscribeToNextLyric = NativeAppEventEmitter.addListener(
      'hello.NextLyric', this._onNextLyric
    );

    this.subscribeToRandLyric = NativeAppEventEmitter.addListener(
      'hello.NextLyricRandom', this._onNextLyric
    );
  }

  componentWillUnmount() {
    this.subscribeToNextLyric.remove();
    this.subscribeToRandLyric.remove();
  }

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.header}>
          Adele Sings On React
        </Text>
        <Text style={styles.lyrics}>
          {this.state.lyric}
        </Text>
        <View style={styles.buttonBar}>
          <TouchableHighlight style={styles.touchable}
            onPress={this._onPressAdeleSings}>
            <View style={styles.button}>
              <Text style={styles.buttonText}>
                Adele Sings
              </Text>
            </View>
          </TouchableHighlight>
          <TouchableHighlight style={styles.touchable}
            onPress={this._onPressLionelSings}>
            <View style={styles.button}>
              <Text style={styles.buttonText}>
                Lionel Sings
              </Text>
            </View>
          </TouchableHighlight>
          <TouchableHighlight style={styles.touchable}
            onPress={this._onPressRandomSings}>
            <View style={styles.button}>
              <Text style={styles.buttonText}>
                Random
              </Text>
            </View>
          </TouchableHighlight>
        </View>
      </View>
    );
  }

  // Button Listeners
  _onPressLionelSings() {
    LyricsManager.playNextLionelLyric();
  }
  _onPressAdeleSings() {
    LyricsManager.playNextAdeleLyric();
  }
  _onPressRandomSings() {
    LyricsManager.playNextLyricRandom();
  }

  // Event Listeners
  _onNextLyric(eventData) {
    console.log(eventData);
    this.setState(eventData);
  }

  _onLyricRandom(eventData) {
    console.log("Random");
    var rand = Math.floor((Math.random() * 10) + 1);
    var singer = "";

    if (rand % 2 == 0) {
      singer = "Lionel";
    } else {
      singer = "Adele";
    }

    LyricsManager.playNextLyricBy(singer);
  }
}

var styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'column',
    justifyContent: 'flex-start',
    paddingTop: 0
  },
  header: {
    backgroundColor: '#D2D3D4',
    fontSize: 24,
    fontWeight: 'bold',
    alignSelf: "stretch",
    textAlign: 'center',
    padding: 10
  },
  lyrics: {
    fontSize: 16,
    alignSelf: "stretch",
    textAlign: 'left',
    margin: 20
  },
  touchable: {
  },
  buttonBar: {
    flexDirection: 'row',
    alignSelf: "stretch",
    justifyContent: 'center'
  },
  button: {
    backgroundColor: '#1862ED',
    height: 44,
    width: 100,
    margin: 5,
    justifyContent: 'center'
  },
  buttonText: {
    fontSize: 16,
    textAlign: 'center',
    margin: 10,
    color: '#FFFFFF'
  }
});

module.exports = HelloApp;
