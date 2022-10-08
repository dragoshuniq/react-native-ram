import * as React from 'react';

import { StyleSheet, View, Text } from 'react-native';
import { getAllRamInfo } from 'react-native-ram';
import type { RamState } from 'react-native-ram';

export default function App() {
  const [result, setResult] = React.useState<RamState>();

  React.useEffect(() => {
    getAllRamInfo().then((res: RamState) => {
      setResult(res);
    });
  }, []);

  return (
    <View style={styles.container}>
      <Text>RAM INFO: {JSON.stringify(result, null, 2)}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
